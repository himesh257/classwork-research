def CaesarCipherEncryption(textToBeEncrypted, shift):
    # we must initialize the variable in the begining
    encryptedString = ""

    """
        we will have to traverse the entire text,
        meaning we will be looking at each character in the string
    """

    for i in range(len(textToBeEncrypted)):
        char = textToBeEncrypted[i]

        """
            we need to check for both uppercase and lowercase
            character, and hence, we have an if clause for that
        """

        if (char.isupper()):
            # basic formula for computation
            encryptedString += chr((ord(char) + shift - 65) % 26 + 65)
        else:
            # basic formula for computation
            encryptedString += chr((ord(char) + shift - 97) % 26 + 97)

    return encryptedString

if __name__== "__main__":
    textToBeEncrypted = "ExampleString"
    shift = 4
    print("Encrypted String: " + CaesarCipherEncryption(textToBeEncrypted, shift))
