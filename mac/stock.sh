stocks=( 'GOOG' 'FB' 'MSFT' 'TSLAT' 'WMT' 'TWTR')

for i in "${stocks[@]}"
do
       :
    echo $i : $`curl -s "http://download.finance.yahoo.com/d/quotes.csv?s=$i&f=l1"`

done

