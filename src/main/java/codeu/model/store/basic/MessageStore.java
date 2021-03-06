// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package codeu.model.store.basic;

import codeu.model.data.Message;
import codeu.model.store.persistence.PersistentStorageAgent;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import codeu.model.data.User;

/**
 * Store class that uses in-memory data structures to hold values and automatically loads from and
 * saves to PersistentStorageAgent. It's a singleton so all servlet classes can access the same
 * instance.
 */
public class MessageStore {

  /** Singleton instance of MessageStore. */
  private static MessageStore instance;

  /**
   * Returns the singleton instance of MessageStore that should be shared between all servlet
   * classes. Do not call this function from a test; use getTestInstance() instead.
   */
  public static MessageStore getInstance() {
    if (instance == null) {
      instance = new MessageStore(PersistentStorageAgent.getInstance());
    }
    return instance;
  }

  /**
   * Instance getter function used for testing. Supply a mock for PersistentStorageAgent.
   *
   * @param persistentStorageAgent a mock used for testing
   */
  public static MessageStore getTestInstance(PersistentStorageAgent persistentStorageAgent) {
    return new MessageStore(persistentStorageAgent);
  }

  /**
   * The PersistentStorageAgent responsible for loading Messages from and saving Messages to
   * Datastore.
   */
  private PersistentStorageAgent persistentStorageAgent;

  /** The in-memory list of Messages. */
  private List<Message> messages;

  /** This class is a singleton, so its constructor is private. Call getInstance() instead. */
  private MessageStore(PersistentStorageAgent persistentStorageAgent) {
    this.persistentStorageAgent = persistentStorageAgent;
    messages = new ArrayList<>();
  }

  /** Add a new message to the current set of messages known to the application. */
  public void addMessage(Message message) {
    messages.add(message);
    persistentStorageAgent.writeThrough(message);
  }

  /** Access the current set of messages known to the application. */
  public List<Message> getAllMessages() {
    return messages;
  }

  /** Access the current set of Messages within the given Conversation. */
  public List<Message> getMessagesInConversation(UUID conversationId, UUID userId) {

    List<Message> messagesInConversation = new ArrayList<>();

    if (userId != null){
      for (Message message : messages) {
        if (message.getConversationId().equals(conversationId) && (!message.getDeleteForUser().contains(userId))) {
          messagesInConversation.add(message);
        }
      }
    }

    else {
      for (Message message : messages) {
        if (message.getConversationId().equals(conversationId)) {
          messagesInConversation.add(message);
        }
      }
    }

    return messagesInConversation;
  }

  /** Access the current set of Messages sent by the user. */
  public List<Message> getUserMessages(UUID userId) {

    List<Message> userMessages = new ArrayList<>();

    for (Message message : messages) {
      if (message.getAuthorId().equals(userId)) {
        userMessages.add(message);
      }
    }

    return userMessages;
  }

  /** Sets the List of Messages stored by this MessageStore. */
  public void setMessages(List<Message> messages) {
    this.messages = messages;
  }

  /** loops through all of users messages until message to be deleted is found */
  public boolean deleteUserMessage(UUID userId, Message deleteMessage){
     List<Message> conversationMessages = getMessagesInConversation(deleteMessage.getConversationId(), userId);
    // if (deleteMessage.getAuthorId().equals(userId)){
      for (Message message : conversationMessages){
        if (message.getId().equals(deleteMessage.getId())){
          deleteMessage.addDeleteForUser(userId);

          // display success message:
          return true;
        }
    }
    //else: display error message:
    return false;
  }

  /** Find and return the Message with the given title. */
  public Message getMessageWithId(String messageId) {
    for (Message message : messages) {
      String messageString = message.getId().toString();
      if (messageString.equals(messageId)) {
        return message;
      }
    }
    return null;
  }

}
