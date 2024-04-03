class button
{
    int x ;
    int y ;
    int xSize;
    int ySize ;
    int _textSize ; 

    String command ;
    String description ;



    button( int x, int y, int xSize, int ySize, int _textSize, String description, String command )
    {
        this.x = x * xSize;
        this.y = y * ySize;
        this.xSize = xSize ;
        this.ySize = ySize ;
        this._textSize = _textSize ;
        this.description = description ;
        this.command     = command ;
    }

    void draw()
    {        // size x  y
        if( hoveringOver() )    fill(255,0,0) ; // grey
        else                    fill(200,0,0);  // white
        
        rect(x+1, y+1, xSize-2, ySize-2 ) ;
        textAlign( CENTER, TOP ) ;
        textSize( _textSize ) ;
        fill( 0 ) ; // black
        text( description, x+ (xSize/2) , y ) ;
    }

    void click()
    {
        if( hoveringOver() ) println( command ) ;
    }

    boolean hoveringOver()
    {
        if( mouseX >= x && mouseX <= (x + xSize)
        &&  mouseY >= y && mouseY <= (y + ySize) )
        {
            return true ;
        }

        return false ;
    }

    byte[] getCommand()
    {
        return command.getBytes() ; // has to be a byte array, not a string
    }

} ;