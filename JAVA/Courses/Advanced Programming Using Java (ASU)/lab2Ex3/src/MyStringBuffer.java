public class MyStringBuffer {
    // String class by default is immutable, so we need to store it in an array of char since arrays are mutable.
    private char[] buffer;

    MyStringBuffer(String str) {  // you can also use buffer = s.toCharArray()
        int size = str.length();
        buffer = new char[size];
        for (int i = 0; i < size; i++)
            buffer[i] = str.charAt(i);
    }

    String getString() {
        return new String(buffer);
    }

    void print() {
        System.out.println(buffer);
        // or you can print each char using 'for(char ch : buffer) System.out.print(ch) ;'
        // or use new String(buffer)
    }

    int length() {
        return buffer.length;
    }
    int indexOf(char c)
    {
        for (int i = 0; i < length(); i++)
            if (buffer[i] == c)
                return i ;

        return -1;
    }

    void erase(int index, int length)
    {
        // check if index is in the range of buffer array
        if (  index >= buffer.length || index < 0 )
            return;

        if (index + length > buffer.length) // if the region is outside the buffer region , erase all chars starting from 'index' to the end of the string.
            length = buffer.length - index ;

        // you can use 'this.length()'
        int newSize = buffer.length - length; // length()--> array size before erasing , length --> nymber of chars that will be erased.
        char[] tempBuffer = new char[newSize];
        int i_buffer = 0 , i_temp = 0;
        while (i_buffer < buffer.length)
        {
            if (i_buffer == index) // if i == index -> skip the region starting from index to index + length (the region that will be erased).
                i_buffer += length;
            else
                tempBuffer[i_temp++] = buffer[i_buffer++];
        }
        buffer = tempBuffer;
    }
    void insert(int index, String str)
    {
        if (buffer.length == 0) // if buffer is empty, assign buffer to str.
        {
            buffer = str.toCharArray();
            return;
        }
        // check if index is in the range of buffer, if not you can choose to return without doing anything or if index is >= buffer length, you can insert at the end of buffer.
        if ( index >= buffer.length || index < 0)
            return;

        int newSize = str.length() + length(); // length() -> buffer length , you can use 'buffer.length'
        char[] tempBuffer = new char[newSize];

        int lowerLimit = index;
        int upperLimit = index + str.length() - 1;
        int i_buffer = 0;
        for (int i_temp = 0; i_temp < newSize; i_temp++)
        {
            boolean isInsideRange = (i_temp >= lowerLimit) && (i_temp <= upperLimit);
            if (isInsideRange) // is true when i_temp is inside the inserting range which is from index to index + str.length()-1.
                tempBuffer[i_temp] = str.charAt(i_temp - index);
            else
                tempBuffer[i_temp] = buffer[i_buffer++];
        }
        buffer = tempBuffer;
    }
}