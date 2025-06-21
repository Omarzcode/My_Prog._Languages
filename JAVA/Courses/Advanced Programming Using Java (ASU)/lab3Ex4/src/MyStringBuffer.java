public class MyStringBuffer
{
    private char[] buffer;

    MyStringBuffer(String str)
    {  // you can also use buffer = s.toCharArray()
        int size = str.length();
        buffer = new char[size];
        for (int i = 0; i < size; i++)
            buffer[i] = str.charAt(i);
    }
    String getString()
    {
        return new String(buffer);
    }
    void print()
    {
        System.out.println(buffer);

    }

    int length()
    {
        return buffer.length;
    }

    int indexOf(char c)
    {
        for (int i = 0; i < length(); i++)
            if (buffer[i] == c)
                return i ;

        return -1;
    }

    MyStringBuffer erase(int index, int length)
    {
        MyStringBuffer MSB = new MyStringBuffer("");
        //check if index is in the range of buffer
        if ( index >= buffer.length || index < 0 )
            return MSB;

        if ( index + length > buffer.length )
            length = buffer.length - index ;

        String tempBuffer = "";
        int iBuffer = 0;
        while (iBuffer < buffer.length)
        {
            if (iBuffer == index)
                iBuffer += length;
            else
                tempBuffer += buffer[iBuffer++];
        }
        MSB.buffer = tempBuffer.toCharArray();
        return MSB ;
    }

    MyStringBuffer insert(int index, String str)
    {
        MyStringBuffer MSB = new MyStringBuffer("");
        String tempBuffer = "";
        if (index < 0)
            return MSB;
        if (index > buffer.length - 1)
        {
            tempBuffer = new String(buffer) + str; // copy constrcutor will take the array of char buffer and convert it to string.
            MSB.buffer = tempBuffer.toCharArray();
            return MSB;
        }

        for (int i_buffer = 0; i_buffer < buffer.length ; i_buffer++)
        {
            if (i_buffer == index)
                tempBuffer += str;

            tempBuffer += buffer[i_buffer];
        }
        MSB.buffer = tempBuffer.toCharArray();
        return MSB;
    }

}
