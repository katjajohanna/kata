require 'benchmark'

def chop(lost_int, list, offset = 0)
    length = list.length

    if length <= 1
        return list.index(lost_int) + offset if list.include? lost_int
        return -1
    end

    half_length = length / 2
    return list.index(lost_int) + offset if list[0..half_length - 1].include? lost_int
    return chop(lost_int, list[half_length..length], offset + half_length)
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

    context "Takes less time than search from whole list" do
        it "Takes less time" do
            long_list = []
            for i in 1..10_000_000
                long_list << i
            end

            lost_int = 8_803_030

            chop_time = Benchmark.measure {
                chop(lost_int, long_list)
            }

            list_time = Benchmark.measure {
                long_list.include? lost_int
            }

            expect(chop_time.to_a()[5]).to be < list_time.to_a()[5]
        end
    end
end
