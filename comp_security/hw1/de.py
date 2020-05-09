def CaesarCipherDecryption(EncryptedMessage, alphabets):
    """
        just like encryption, we will start by traversing the encrypted string
    """

    for letters in range(len(alphabets)):
        # initializing the decrypted string, which will be initialized
        # at every iteration
        decrypted = ''

        for symbol in EncryptedMessage:

            """
                we will make sure to encounter any symbols
                included in the string
            """

            if symbol in alphabets:
                num = alphabets.find(symbol)
                num = num - letters
                if num < 0:
                    num = num + len(alphabets)
                decrypted = decrypted + alphabets[num]
            else:
                decrypted = decrypted + symbol

    return decrypted

if __name__== "__main__":
    EncryptedMessage = 'KhjujniPnbghj'
    alphabets = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    print("Decrypted String: " + CaesarCipherDecryption(EncryptedMessage, alphabets))
