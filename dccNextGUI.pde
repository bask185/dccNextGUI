import com.fazecast.jSerialComm.* ;

ArrayList <button> buttons = new ArrayList() ;
SerialPort dccNext ;
InputStream inputStream ;

final int buttonSizeX       = 150 ;
final int buttonSizeY       = 100 ;
final int buttonTextSize    =  30 ;

String receivedText = "";


void settings()
{
    size(displayWidth, displayHeight) ;
}

void setup()
{

    buttons.add( new button(  0, 0, buttonSizeX, buttonSizeY, buttonTextSize,   "help", "?") ) ;
    buttons.add( new button(  0, 1, buttonSizeX, buttonSizeY, buttonTextSize,   "config", "C") ) ;
    buttons.add( new button(  2, 0, buttonSizeX, buttonSizeY, buttonTextSize-8, "select port\r\nby number", "P") ) ;
    buttons.add( new button(  3, 0, buttonSizeX, buttonSizeY, buttonTextSize-8, "select port\r\nby address", "A") ) ;
    buttons.add( new button(  4, 0, buttonSizeX, buttonSizeY, buttonTextSize-8, "Display all", "D") ) ;
    buttons.add( new button(  5, 0, buttonSizeX, buttonSizeY, buttonTextSize,   "Exit", "E") ) ;
    buttons.add( new button(  6, 0, buttonSizeX, buttonSizeY, buttonTextSize-8, "set basic\r\ninformation", "I") ) ;
    buttons.add( new button(  7, 0, buttonSizeX, buttonSizeY, buttonTextSize,   "RESET", "R") ) ;

    buttons.add( new button(  5, 6, buttonSizeX, buttonSizeY, buttonTextSize+20,   "0", "0") ) ;
    buttons.add( new button(  4, 3, buttonSizeX, buttonSizeY, buttonTextSize+20,   "1", "1") ) ;
    buttons.add( new button(  5, 3, buttonSizeX, buttonSizeY, buttonTextSize+20,   "2", "2") ) ;
    buttons.add( new button(  6, 3, buttonSizeX, buttonSizeY, buttonTextSize+20,   "3", "3") ) ;
    buttons.add( new button(  4, 4, buttonSizeX, buttonSizeY, buttonTextSize+20,   "4", "4") ) ;
    buttons.add( new button(  5, 4, buttonSizeX, buttonSizeY, buttonTextSize+20,   "5", "5") ) ;
    buttons.add( new button(  6, 4, buttonSizeX, buttonSizeY, buttonTextSize+20,   "6", "6") ) ;
    buttons.add( new button(  4, 5, buttonSizeX, buttonSizeY, buttonTextSize+20,   "7", "7") ) ;
    buttons.add( new button(  5, 5, buttonSizeX, buttonSizeY, buttonTextSize+20,   "8", "8") ) ;
    buttons.add( new button(  6, 5, buttonSizeX, buttonSizeY, buttonTextSize+20,   "9", "9") ) ;

    SerialPort[] serialPorts = dccNext.getCommPorts() ;   
    for (SerialPort port: serialPorts)
    {           
        if( port.getDescriptivePortName().contains("Uno")
        ||  port.getDescriptivePortName().contains("CH340"))
        {
            println("dccNext found") ;
            try
            {
                dccNext = port ;

                dccNext.setBaudRate( 57600 ) ;
                if( dccNext.openPort() ) println("Serial port opened!") ;
                else                     println("Serial port opening !!!FAILED!!!") ;

            }
            catch (NullPointerException e)
            {
                println("NullPointerException") ;
            }
        }
    }

    inputStream = dccNext.getInputStream() ;
}

void draw()
{
    // whipe screen with new back ground
    background(100) ;

    // draw right rectangle
    fill(200);                                          
    rect(width-400, 0, 400, height);

    // draw serial received text
    textSize(17);
    textAlign(LEFT,TOP);
    fill(0);
    text( receivedText, width-390, 10) ;

    // draw all buttons
    for (int i = 0; i < buttons.size(); i++)            // loop through all blocks
    {
        button btn = buttons.get(i) ;                   // declare a local button obj and draw() it
        btn.draw() ;
    }

    //
    try{
        if( inputStream.available() > 0 )
        {   delay(100);

            String s = "" ;
            while( inputStream.available() > 0 )
            {
                s += (char)inputStream.read() ;
            }
            
            println(s) ;
            receivedText = s ;
        }
    }
    catch (IOException e ) {;}

}

void mouseClicked()                                   // if any mouse button is clicked
{
    for (int i = 0; i < buttons.size(); i++)          // loop through all blocks
    {
        button btn = buttons.get(i) ;                 // declare a local button obj and draw() it

        if( btn.hoveringOver() )
        {
            byte[] byteArray = btn.getCommand() ;
            dccNext.writeBytes( byteArray, byteArray.length ); 
            printArray(byteArray);
        }
    }
}