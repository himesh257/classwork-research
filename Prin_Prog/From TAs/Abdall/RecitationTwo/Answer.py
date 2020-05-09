def playGame(listOfCards):
    best_distance = -1

    indexer = dict()

    for idx, val in enumerate(listOfCards):
        if val not in indexer:
            indexer[val] = idx
        else:
            lastSeenIndex = indexer.get(val)
            distance = idx - lastSeenIndex

            if distance < best_distance or best_distance == -1:
                best_distance = distance+1

            indexer[val] = idx

    return best_distance



print(playGame([1, 2, 2, 8]))
