component accessors="true" extends="commandbox.system.BaseCommand" singleton{

	property terminalApp;
	property emojiOffset;
	property width;

	function onDIComplete(){
		setTerminalApp(  trim( command('!echo $TERM_PROGRAM').run( returnOutput = true ) ) );
		if( getTerminalApp() == "vscode" ){
			setWidth( shell.getTermWidth() / 2 );
			setEmojiOffset( 1 );
		}else{
			setWidth( command('!tput cols').run( returnOutput = true ) );
			setEmojiOffset( 2 );
		}

		return this;
	}

	function printMessageBox( required any message, border = "🔥", color = "white", borderColor = "red", wordwrap = true, columns = 80 ){
		if( !isArray( message ) ) message = [message];
		var isBorderMultiByteChar = len(border) > 1 && charsetDecode( border, "UTF-8")[1] < 0;
		var borderCharacterLength = isBorderMultiByteChar ? getEmojiOffset()+arrayLen( charsetDecode( left( border, 1), "UTF-8") )/2 : len( border );
		var borderWidth = (getWidth()+(floor(borderCharacterLength)*2));
		var borderString = repeatString(border, borderWidth );
		// Trim border down to size.
		borderString = left( borderString, borderWidth );

		print.boldLine( borderString, borderColor ).toConsole();
		// Word wrap
		if( wordWrap ){
			message = message.reduce((prev,line)=>{
				prev.append( line.reReplace("([^\n]{1,#columns#})", "\1#chr(999)#", "all" ).listToArray(chr(999)), true );
				return prev;
			},[]);
		}
		// Add border, center text
		message.each(( line, index ) => {
			var padding = floor(( ( getWidth() - line.len() ) / 2 ));
			if( padding < 0 ) padding = 0;
			var remainder = ( ( getWidth() - line.len() ) / 2 ) - padding;
			print.boldText( border, borderColor )
					.boldText( repeatString(" ", padding) & line & repeatString(" ", padding + (remainder > 0 ? 1 : 0 ) ), color )
				.boldText( border, borderColor ).line();
		});
		print.boldText( borderString, borderColor ).line().line().toConsole();
	}
}