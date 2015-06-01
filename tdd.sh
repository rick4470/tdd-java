# Short script that compiles and test a java code project
# The prject should be entered like this 
# tdd /location/of/project MainClass 
# no java extension is need 
# tdd ProjectName // will create a new project
#

clear


javaVersion=`/usr/libexec/java_home -v 1.7`

: ${dir:="$1"}
: ${mainClass:="$2"}

firstletter=${dir:0:1}

if [ ! -f /Library/Java/Extensions/junit-4.11.jar ]; then
	echo $(tput setaf 1) #set color to red 
    echo "Junit is not installed please get a fresh copy!" 
fi

if [ ! $javaVersion ]; then
	echo $(tput setaf 1) #set color to red 
    echo "java is not installed!"
fi

if [ ! "${firstletter}" = "/" ]; then
	echo "\033[34mSettingup the Test Driven Development(TDD) please wait..... \033[0m"

	algorithmLocation="/Users/Developer/Desktop/Algorithms"

	: ${projectName:="$dir"}

	if [ ! -d "/Users/Developer/Desktop/Algorithms/$projectName" ]; then
		echo "Creating direcotries please wait...."
		if [ ! -d "/Users/Developer/Desktop/Algorithms" ]; then
			mkdir $algorithmLocation
		fi
		mkdir $algorithmLocation/$projectName
		mkdir $algorithmLocation/$projectName/program
		mkdir $algorithmLocation/$projectName/unitTest
		mkdir $algorithmLocation/$projectName/compiled

		javaTemplate="public class Main
{ 
	public static void main(String [] args)
	{
		
	}	
}
	";
		destdir=$algorithmLocation/$projectName/program/Main.java

		if [ ! -f $algorithmLocation/$projectName/program/Main.java ]
		then
			echo "$javaTemplate" > "$destdir"
		fi
		echo "All done happy coding"
	fi
	exit 0
fi

echo "\033[34mRunning Test Driven Development(TDD) please wait..... \033[0m"
if [ ! $1 ]; then
	echo $(tput setaf 1) #set color to red 
    echo "Hey you did not give me a correct directory try again!"
    echo "Remember its tdd /mydir/project/package"
fi
compileProject(){
	echo "compiling project(press any key to stop)"
	if [ ! -d "$dir/compiled" ]; then
		echo $(tput setaf 3) #set color to yelow 
		echo "-----> Making a compiled folder at $dir/compiled"
		mkdir $dir/compiled
		echo "$(tput sgr0)" #reset color
	fi

	if [ ! $mainClass ]; 
		then
			echo $(tput setaf 1) #set color to red 
			echo "Hey there is no main class try again!"
		    echo "$(tput sgr0)" #reset color
	    else
			echo $(tput setaf 3) #set color to yelow 
			echo "-----> Found Main class compiling......"
			javac -cp $dir:/Library/Java/Extensions/junit-4.11.jar -d $dir/compiled $dir/unitTest/UnitTestSuit.java $dir/unitTest/$mainClass.java #|| javac -classpath $dir -d $dir/compiled $dir/program/$mainClass.java
			echo "$(tput sgr0)" #reset color
	fi
}

unitTestProject(){
	echo "unit testing project"
	passOrFail=$(java $mainClass)  

	if [ "${passOrFail}" = "true" ] ; then
		boolVal=true; 
	else 
		boolVal=false; 
	fi

	if ! $boolVal; 
		then
			echo $(tput setab 1) #set color to red 
			echo "                                                        ";
			echo "FAIL                                                    ";
			echo "$passOrFail                                             ";
			echo "                                                        ";
		    echo "$(tput sgr0)" #reset color
	    else
			echo $(tput setab 2) #set color to green 
			echo "                                                        ";
			echo "All Good Keep Cooding!                                  ";
			echo "                                                        ";
			echo "$(tput sgr0)" #reset color
	fi

}

if [ -t 0 ]; then stty -echo -icanon time 0 min 0; fi
tput civis      -- invisible
count=0
keypress=''
while [ "x$keypress" = "x" ]; do
	read keypress
  	let count+=1
  	compileProject
	unitTestProject
	echo "$(tput sgr0)" #reset color
	sleep 3
	clear
done

if [ -t 0 ]; then stty sane; fi

echo "Great job! with TDD developing, you compiled this $count times."
tput cnorm   -- normal #give me back the cursor
exit 0

# good compile
# javac -cp /Users/Developer/Desktop/Test:/Library/Java/Extensions/junit-4.11.jar TestExample.java
# javac -cp /Users/Developer/Desktop/Test:/Library/Java/Extensions/junit-4.11.jar -d /Users/Developer/Desktop/Test/compiled /Users/Developer/Desktop/Test/unitTest/UnitTestSuit.java /Users/Developer/Desktop/Test/unitTest/TDDExcute.java



