
#include <iostream>
#include <cstring>

#include "lunasvg/svgdocument.h"

using namespace lunasvg;

int main(int argc, char** argv)
{
    std::uint32_t width = 512, height = 512;
    std::string fileName;
    std::uint32_t bgColor = 0x00000000;

    char* path = nullptr;

    path = argv[1];
    fileName = std::string(path);

    SVGDocument document;
    if(!document.loadFromFile(fileName)){
        std::cout << "ERROR COULD not load file"  << std::endl;
        return 1;
    } 


    std::string baseName = fileName.substr(fileName.find_last_of("/\\") + 1);
    baseName.append(".png");


    Bitmap bitmap = document.renderToBitmap(width, height, 96.0, bgColor);
    std::cout << "Generated PNG file : "<< baseName << std::endl;
    return 0;
}