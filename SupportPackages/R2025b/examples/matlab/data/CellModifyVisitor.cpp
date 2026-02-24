#include "MatlabDataArray.hpp"
#include "MatlabEngine.hpp"
#include <iostream>

using namespace matlab::data;
void ModifyCell(CellArray &cellArray);

class CellModifyVisitor {
public:
    template <typename U>
    void operator()(U arr) {}

    void operator()(TypedArrayRef<bool> boolArrRef) {
        std::cout << "Negate logical value: " << std::endl;
        for (auto &b : boolArrRef) {
            b = !b;
        }       
    }

    void operator()(TypedArrayRef<double> doubleArrRef) {
        std::cout << "Add 1 to each value: " << std::endl;
        for (auto &elem : doubleArrRef) {
            elem = elem + 1;
        }
        std::cout << "\n";
    }

    void operator()(CharArrayRef charArrRef) {
        std::cout << "Modify char array" << std::endl;
        ArrayFactory factory;
        charArrRef = factory.createCharArray("Modified char array");
    }
 
    void operator()(CellArrayRef containedCellArray) {
        CellModifyVisitor v;
        for (auto elem : containedCellArray) {
            apply_visitor_ref(elem, v);
        }
    }
    
};

void ModifyCell(CellArray &cellArray) {
    CellModifyVisitor v;
    for (auto elem : cellArray) {
        apply_visitor_ref(elem, v);
    }
}