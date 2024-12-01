import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:MyJob/Models/Conversation.dart';
import 'package:MyJob/Models/Employer/Employer.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:MyJob/Repositories/user/User_Repository.dart';
import 'package:MyJob/Repositories/Chat/chatRepository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MessagesController extends GetxController {
  static MessagesController get instance => Get.find();

  // variables
  RxBool isLoading = false.obs;
  final currentUser = AuthenticationRepository.instance.authUser!.uid;
  final userRepo = UserRepository.Instance;
  final chatRepo = Get.put(ChatRepository());
  RxList<Conversation> Conversations = <Conversation>[].obs;
  RxList<Employer> EmployersInfos = <Employer>[].obs;

  TextEditingController messageController = TextEditingController();

  @override
  void onInit() {
    getConversations();
    super.onInit();
  }

  void getConversations() async {
    try {
      isLoading.value = true;
      Conversations.value = await chatRepo.getChats("jobSeekerId");

      for (var conversation in Conversations) {
        final employerData =
            await userRepo.getEmployerDataById(conversation.EmployerId);
        if (!EmployersInfos.any(
            (existEmp) => existEmp.EmployerId == employerData.EmployerId)) {
          EmployersInfos.add(employerData);
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  // send message

  void sendMessage(
    String ConversationId,
    ReceiverId,
  ) async {
    if (messageController.text.isNotEmpty) {
      await chatRepo.sendMessage(
          ConversationId, ReceiverId, messageController.text, false);
      messageController.clear();
    }
  }

  // send image
  void sendImage(
      String ConversationId, String ReceiverId, String ImageUrl) async {
    if (ImageUrl.isNotEmpty) {
      await chatRepo.sendMessage(ConversationId, ReceiverId, ImageUrl, true);
    }
  }

  // upload image
  void uploadImage(
    String ConversationId,
    ReceiverId,
  ) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageUrl = await userRepo.uploadimage('User/chats/images', image);
      sendImage(ConversationId, ReceiverId, imageUrl);
    }
  }

  Future<void> markMessagesAsRead(
      String conversationId, String ReceiverId) async {
    final _unseenCountStream = await FirebaseFirestore.instance
        .collection('chats')
        .doc(conversationId)
        .collection('messages')
        .where('senderId', isEqualTo: ReceiverId)
        .where('isRead', isEqualTo: false)
        .get();

    if (_unseenCountStream.docs.isNotEmpty) {
      final batch = FirebaseFirestore.instance.batch();
      for (var message in _unseenCountStream.docs) {
        batch.update(message.reference, {'isRead': true});
      }
      await batch.commit();
    }
  }

  final ImagePicker _picker = ImagePicker();
  final selectedImage = Rx<File?>(null);

  Future<XFile?> pickImage() async {
    try {
      final XFile? pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      return pickedImage;
    } catch (e) {
      // Handle exceptions (e.g., permission errors, canceled selection)
      if (Get.isDialogOpen!) return null; // Prevent multiple error dialogs
      Get.snackbar(
        "Error",
        "Failed to access gallery: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  Future<void> pickAndPreviewImage() async {
    final XFile? imageFile = await pickImage();
    final file = imageFile != null ? File(imageFile.path) : null;
    selectedImage.value = file;
  }
}
