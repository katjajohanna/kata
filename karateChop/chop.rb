def chop(lost_int, list)
    length = list.length
    first_half = list[0..length / 2 - 1]

    return list.index(lost_int) if first_half.include? lost_int

    second_half = list[length / 2..length]

    return list.index(lost_int) if second_half.include? lost_int

    -1
end

describe "Searching int from list" do
    context "Int is included in array" do
        {
            1 => {:list => [1], :position => 0},
            1 => {:list => [2, 1], :position => 1},
            1 => {:list => [1, 3, 5], :position => 0},
            3 => {:list => [1, 3, 5], :position => 1},
            5 => {:list => [1, 3, 5], :position => 2},
            1 => {:list => [1, 3, 5, 7], :position => 0},
            3 => {:list => [1, 3, 5, 7], :position => 1},
            5 => {:list => [1, 3, 5, 7], :position => 2},
            7 => {:list => [1, 3, 5, 7], :position => 3},
        }.each_pair do |lost_int, data|
            it "Finds #{lost_int} in #{data[:list]}" do
                expect(chop(lost_int, data[:list])).to eq(data[:position])
            end
        end
    end

    context "Int is not included in array" do
        {
            3 => [],
            3 => [1],
            0 => [1, 3, 5],
            2 => [1, 3, 5],
            4 => [1, 3, 5],
            6 => [1, 3, 5],
            0 => [1, 3, 5, 7],
            2 => [1, 3, 5, 7],
            4 => [1, 3, 5, 7],
            6 => [1, 3, 5, 7],
            8 => [1, 3, 5, 7],
        }.each_pair do |lost_int, list|
            it "Does not find #{lost_int} in #{list}" do
                expect(chop(lost_int, list)).to eq(-1)
            end
        end
    end
end
