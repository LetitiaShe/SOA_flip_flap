# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    tsv_lines = []
    @data = []

    tsv.each_line do |line|
      tsv_lines << line
    end

    for i in 0..tsv_lines.length-1
	    tsv_lines[i] = tsv_lines[i].split("\t")
    end

    keys = tsv_lines[0]
    keys.map! {|x| x.chomp}
    tsv_lines.shift

    tsv_lines.each do |line|
	    record = Hash.new
	    keys.each_index {|index| record[keys[index]] = line[index].chomp}
	    @data.push(record)
    end

  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    first = @data[0]
    keys_array = first.keys
    line = ""
    for i in 0...keys_array.length
      if i < keys_array.length-1
        line = line + keys_array[i] + "\t"
      else
        line = line + keys_array[i] + "\n"
      end
    end

    @data.each do |record|
      record.each_with_index do |(key, value), index|
        if index < record.length-1
          line << value + "\t"
        else
          line << value + "\n"
        end
      end
    end
    return line
  end

end
