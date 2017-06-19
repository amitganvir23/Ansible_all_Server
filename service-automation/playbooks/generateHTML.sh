#! /bin/bash

    if [ $# -eq 0 ] ; then
       echo "USAGE: $(basename $0) file1 file2 file3 ..."
       exit 1
    fi

    for file in $* ; do
       html=$(echo $file | sed 's/\.txt$/\.html/i')

       echo "<html>" >> $html
       echo "   <body>" >> $html
       echo '<table border="1">' >> $html
       echo '<th>APPLICATION</th>' >> $html
       echo '<th>IP ADDRESS</th>' >> $html
       echo '<th>STATUS</th>' >> $html
       while IFS=';' read -ra line ; do
        echo "<tr>" >> $html
        for i in "${line[@]}"; do
           echo "<td>$i</td>" >> $html
         # echo "<td>$i</td>" >> $html
          done
         echo "</tr>" >> $html
       done < $file
        echo '</table>' >> $html
        echo "   </body>" >> $html
        echo "</html>" >> $html
    done

