from sys import exit
import argparse  
from pathlib import Path
from PIL import Image
from os import path

def is_image(file):
    try:
        with Image.open(file) as image:
            image.verify()
            return True
    except (IOError, SyntaxError):
        return False

def main():
    parser = argparse.ArgumentParser(description='Map image pixels for use in Minecraft\'s ArtMap plugin.',
                                    formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('-i', '--input', help='Input image file path.', type=str, required=True)
    parser.add_argument('-x1', '--x-begin', help='The x pixel to begin mapping.', type=int, required=True)
    parser.add_argument('-x2', '--x-end', help='The x pixel to end mapping.', type=int, required=True)
    parser.add_argument('-y1', '--y-begin', help='The y pixel to begin mapping.', type=int, required=True)
    parser.add_argument('-y2', '--y-end', help='The y pixel to end mapping.', type=int, required=True)
    arguments = parser.parse_args()

    input_file = Path(arguments.input)
    if not path.exists(input_file.__str__()):
        print('File: \"' + input_file.__str__() + '\" does not exist.')
        exit(1)
    else:
        if not path.isfile(input_file.__str__()):
            print('File: \"' + input_file.__str__() + '\" is not a file.')
            exit(2)
        if not is_image(input_file.__str__()):
            print('File: \"' + input_file.__str__() + '\" is not a valid image file.')
            exit(3)

    arguments.x_begin -= 1
    arguments.y_begin -= 1
    try:
        image = Image.open(input_file)
    except:
        print('Could not open ' + image.__str__() + " for writing for an unknown reason.")
        exit(4)

    try:
        for y in range(arguments.y_begin, arguments.y_end):
            for x in range(arguments.x_begin, arguments.x_end):
                rgb_image = image.convert('RGB')
                r, g, b = rgb_image.getpixel((x, y))
                print('0x%06x' % ((r << 0x10) + (g << 0x8) + b))
    except KeyboardInterrupt:
        print('\nUser cancelled operation...\n')
    image.close()  
    exit(0)

if __name__ ==  '__main__':
    main()
