int main() {
    ArrayFactory factory;

    // Create cell array
    matlab::data::CellArray cellArray = factory.createCellArray({ 1,4 },
        factory.createCharArray("A char array"),
        factory.createArray<bool>({ 1,2 }, { false, true }),
        factory.createArray<double>({ 2,2 }, { 1.2, 2.2, 3.2, 4.2 }),
        factory.createCellArray({ 1,1 }, false));

    // Call function
    ModifyCell(cellArray);

    return 0;
}
