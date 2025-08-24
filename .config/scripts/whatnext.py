# Literally just a thing that tells me what to do next when I procrastinate.
import random

num = random.randint(0, 1)

match num:
    case 0:
        print("work on a video lazy")
    case 1:
        print("work on tortillas")
    case 2:
        print("work on investments")
