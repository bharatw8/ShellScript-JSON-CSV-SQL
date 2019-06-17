
function format_data
{
	dt1=$1
	dt2=$2
	curl "https://api.exchangeratesapi.io/history?start_at="$dt1"&end_at="$dt2"&symbols=CAD,INR,USD,CNY,GBP" > data.txt
	(json_reformat < data.txt) > data.json
	sed -i '1,2d' data.json; sed -i 's/\"rates\"\://g' data.json; sed -i '/end/d' data.json; sed -i '/start/d' data.json
	sed -i '$d' data.json; sed -i '$s/\,//g' data.json
	grep -iEr "[0-9]{4}-[0-9]{2}-[0-9]{2}" data.json > dates.csv
	sed -i 's/\"//g' dates.csv; sed -i 's/        //g' dates.csv; sed -i 's/: {/,/g' dates.csv
	grep -iEr '"CAD"' data.json > CAD.csv
	grep -iEr '"INR"' data.json > INR.csv
	grep -iEr '"USD"' data.json > USD.csv
	grep -iEr '"CNY"' data.json > CNY.csv
	grep -iEr '"GBP"' data.json > GBP.csv
	sed -i 's/            \"GBP\"\://g' GBP.csv
	sed -i 's/            \"INR\"\://g' INR.csv
	sed -i 's/            \"CAD\"\://g' CAD.csv
	sed -i 's/            \"USD\"\://g' USD.csv
	sed -i 's/            \"CNY\"\://g' CNY.csv
	sed -i 's/ //g' CNY.csv
	sed -i 's/ //g' GBP.csv
	sed -i 's/ //g' INR.csv
	sed -i 's/ //g' USD.csv
	sed -i 's/ //g' CAD.csv
}

function yearly_data
{
	today_date=`date +%Y-%m-%d` 
	last_year_date=`date +%Y-%m-%d -d "-1 year"`
	format_data $last_year_date $today_date
	paste dates.csv CAD.csv USD.csv CNY.csv GBP.csv INR.csv > formatted_year_data.csv
	sed -i 's/ //g' formatted_year_data.csv
	cp formatted_year_data.csv /currencies_data/; chmod -R 777 /currencies_data; 
	psql -U postgres currency_data -c "copy currency_year_data from '/currencies_data/formatted_year_data.csv' DELIMITER ',' csv;" 
	rm -rf dates.csv CAD.csv USD.csv CNY.csv GBP.csv INR.csv data.txt data.json
}


function monthly_data
{
	today_date=`date +%Y-%m-%d` 
	last_month_date=`date +%Y-%m-%d -d "-1 month"`
	format_data $last_month_date $today_date
	paste dates.csv CAD.csv USD.csv CNY.csv GBP.csv INR.csv > formatted_month_data.csv
	sed -i 's/ //g' formatted_month_data.csv
	cp formatted_month_data.csv /currencies_data/; chmod -R 777 /currencies_data; 
	psql -U postgres currency_data -c "copy currency_month_data from '/currencies_data/formatted_month_data.csv' DELIMITER ',' csv;" 
	rm -rf dates.csv CAD.csv USD.csv CNY.csv GBP.csv INR.csv data.txt data.json
}


function weekly_data
{
	today_date=`date +%Y-%m-%d` 
	last_week_date=`date +%Y-%m-%d -d "-1 week"`
	format_data $last_week_date $today_date
	paste dates.csv CAD.csv USD.csv CNY.csv GBP.csv INR.csv > formatted_week_data.csv
	sed -i 's/ //g' formatted_week_data.csv
	cp formatted_week_data.csv /currencies_data/; chmod -R 777 /currencies_data; 
	psql -U postgres currency_data -c "copy currency_week_data from '/currencies_data/formatted_week_data.csv' DELIMITER ',' csv;" 
	rm -rf dates.csv CAD.csv USD.csv CNY.csv GBP.csv INR.csv data.txt data.json
}

yearly_data
monthly_data
weekly_data
