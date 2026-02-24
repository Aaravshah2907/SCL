#include "MatlabDataArray.hpp"
#include <iostream>

using namespace matlab::data;
void DisplayCell(const CellArray cellArray);

    class DisplayVisitor {
    public:
        template <typename U>
        void operator()(U arr) {}

        void operator()(const TypedArray<bool> boolArr) {
            std::cout << "Cell contains logical array: " << std::endl;
            for (auto b : boolArr) {
                printf_s("%d ", b);
            }
            std::cout << "\n";
        }

        void operator()(const TypedArray<double> doubleArr) {
            std::cout << "Cell contains double array: " << std::endl;
            for (auto elem : doubleArr) {
                std::cout << elem << " ";
            }
            std::cout << "\n";
        }

        void operator()(const CharArray charArr) {
            std::cout << "Cell contains char array: " << std::endl;
            for (auto elem : charArr) {
                std::cout << char(elem);
            }
            std::cout << "\n";
        }

        void operator()(const CellArray containedCellArray) {
            DisplayCell(containedCellArray);
        }
    };

    void DisplayCell(const CellArray cellArray) {
        DisplayVisitor v;
        for (auto elem : cellArray) {
            apply_visitor(elem, v);
        }
    }