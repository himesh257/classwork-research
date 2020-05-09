#from __future__ import print_function
class Node:

    def __init__(self, data=None, left=None, right=None):
        self.data = data
        self.left = left
        self.right = right

    def __str__(self):
        return "Node[Data = %s]" % (self.data,)

class BinarySearchTree:
    def __init__(self):
        self.root = None
        self.path = ''

    def insert(self, val):
        if self.root == None:
            self.root = Node(val)
        else:
            current = self.root
            while 1:
                if current.data > val:
                    if current.left == None:
                        current.left = Node(val)
                        break
                    else:
                        current = current.left

                elif current.data < val:
                    if current.right == None:
                        current.right = Node(val)
                        break
                    else:
                        current = current.right

                else:
                    break
    def Insert(self, val):
        if self.root.data == val:
            print("found: root")
            return
        if self.root == None:
            self.root = Node(val)
        else:
            current = self.root
            while 1:
                if current.data > val:
                    if current.left == None:
                        print("not found")
                        return
                    else:
                        self.path += 'l '
                        current = current.left

                elif current.data < val:
                    if current.right == None:
                        print("not found")
                        return
                    else:
                        self.path += 'r '
                        current = current.right

                else:
                    break
            print("found: " + self.path)
            self.path = ''

tree = BinarySearchTree()
valQ = 0
while True:
    try:
        one = input()
        if one.startswith('i'):
            tree.insert(int(one.split('i ',1)[1]))
        if one.startswith('q'):
            valQ = (int(one.split('q ', 1)[1]))
            tree.Insert(valQ)
    except EOFError as error:
        break
