
class Chef
  class Util
    class FileEdit

      def append_line(line)
        @contents << line
      end

      def search_line(regex)
        @contents.each do |line|
          if line.match(regex)
            return line
          end
        end
        return nil
      end

    end
  end
end
