NOTICE!!
1) You need a youtube-dl folder in your User Videos folder. You're free to change that aspect if you would like, under Part 3.
2) For more functionality, you need a youtube-dl.conf file in the root of your user folder. Ex: C:\Users\You 's folder so that the full path is C:\Users\You\youtube-dl.conf
3) In order to be able to use the 'y' command in CMD, what I did was create a youtube-dl folder, placed the youtube-dl.exe in it, along with the y.bat file in that same folder.
4) It is also imperitive that you have the ffmpeg.exe file also in this same very folder. (I've also placed ffplay.exe and ffprobe.exe in there since they all came with the package.)
5) Within Part 5, I've created a substring to just get the filename. This is important and you'll have to calculate the substring of whatever your directory is, so do change the hardcoded 33 unless your username is also 5 characters.

So this is how y.bat works
You enter command y (I'm lazy to fully type it out lol.)
Paste the URL in
Boom, it works.

Prologue: Sets the URL
Part 1: Downloads the video.
Part 2: From what I managed to test, it doesn't download it a second time but gets the path to the newly downloaded file.
Part 3: Replaces all videos in the youtube-dl folder with underscores for ffmpeg's usages. Else, it won't accept spaces in a filename.
Part 4: Replaces the current variable's spaces with underscores.
Part 5: Re-encodes the downloaded video for that delicious AAC and guaratneed Premiere Pro compatability
Epilogue: Deletes the first file that wasn't AAC-coded. In case a duplicate video was downloaded, that is deleted. (For some reason, it avoids having the spaces being replaced with underscores. Oh well(s fargo).)


Extra Special Thanks to:
Schytheron from Github in setting up the ytdlBasic.bat file that I built up upon.
jeb from https://stackoverflow.com/questions/14952295/set-output-of-a-command-as-a-variable-with-pipes
karel from https://superuser.com/questions/1014205/cmd-youtube-dl-store-the-output-filename-as-a-variable
===================================================================================================================================
===================================================================================================================================
Question Jeb Answered:
Can you redirect the output of a command to a variable with pipes?

I haven't tried much as I haven't been able to think of anything to try, but I have tried one method (with two variations)...

For example:

echo Hello|set text=
Didn't work, neither did:

echo Hello | set text=
I know you can do it fairly easily with the FOR command, but I think it would look "nicer" with a pipe.

And if you're wondering, I don't have a specific reason I'm asking this other than I'm curious and I can't find the answer.

Context: 
Your way can't work for two reasons.

You need to use set /p text= for setting the variable with user input.
The other problem is the pipe.
A pipe starts two asynchronous cmd.exe instances and after finishing the job both instances are closed.

That's the cause why it seems that the variables are not set, but a small example shows that they are set but the result is lost later.

set myVar=origin
echo Hello | (set /p myVar= & set myVar)
set myVar
Outputs

Hello
origin
Alternatives: You can use the FOR loop to get values into variables or also temp files.

for /f "delims=" %%A in ('echo hello') do set "var=%%A"
echo %var%
or

>output.tmp echo Hello
>>output.tmp echo world

<output.tmp (
  set /p line1=
  set /p line2=
)
echo %line1%
echo %line2%
Alternative with a macro:

You can use a batch macro, this is a bit like the bash equivalent

@echo off

REM *** Get version string 
%$set% versionString="ver"
echo The version is %versionString[0]%

REM *** Get all drive letters
`%$set% driveLetters="wmic logicaldisk get name /value | findstr "Name""
call :ShowVariable driveLetters
===================================================================================================================================
===================================================================================================================================
Question Karel Answered:
How to store the output filename and extension as a variable after downloading the movie using youtube-dl and use it later in CMD batch? The following is an example of a command to download a video from YouTube to the current directory where URL is the URL of the video.

youtube-dl URL
Store the output filename in a variable called my_variable.

Edit: To be completely specific I want to download a video with youtube-dl using a simple cmd batch file that will provide a CHOICE command at the end with option to open the output file with MPC-HC.

I need the method of putting into a variable the output of

youtube-dl --get-filename -o "%(title)s.%(ext)s" URL
so I can use it later for the following line

"C:\Program Files\MPC-HC\mpc-hc64.exe" "D:\Downloads\%my_variable%" /play

Context:
4

The following command downloads a YouTube video and names it with the same title that it has on YouTube, followed by the downloaded video's extension.

youtube-dl -o "%(title)s.%(ext)s" URL
The following command downloads only the video's title and extension and displays the result in the next line after the command.

youtube-dl --get-filename -o "%(title)s.%(ext)s" URL
The following command in a Windows batch file downloads only the video's title and extension and stores the result in a variable called my_variable.

for /f "delims=" %%a in ('youtube-dl --get-filename -o "%(title)s.%(ext)s" URL') do @set my_variable=%%a
In all three commands you may also use multiple URLs separated by space characters instead of a single URL. You may also use the --batch-file FILE option to replace the URL(s) with a list of URLs stored in a batch file (e.g. FILE).
===================================================================================================================================
===================================================================================================================================