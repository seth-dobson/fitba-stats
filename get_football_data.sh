# shell script to download CSV files from football_data.co.uk
# run in terminal with `sh football_data.sh`

wget https://www.football-data.co.uk/mmz4281/2021/SC0.csv
cut -d , -f 1-24 SC0.csv > src_football_data_scottish_premiership_match_results_2020_2021.csv
mv src_football_data_scottish_premiership_match_results_2020_2021.csv ~/fitba-stats/dbt/data
rm SC0.csv

wget https://www.football-data.co.uk/mmz4281/2020/SC0.csv
cut -d , -f 1-24 SC0.csv > src_football_data_scottish_premiership_match_results_2019_2020.csv
mv src_football_data_scottish_premiership_match_results_2019_2020.csv ~/fitba-stats/dbt/data
rm SC0.csv

wget https://www.football-data.co.uk/mmz4281/2019/SC0.csv
cut -d , -f 1-24 SC0.csv > src_football_data_scottish_premiership_match_results_2018_2019.csv
mv src_football_data_scottish_premiership_match_results_2018_2019.csv ~/fitba-stats/dbt/data
rm SC0.csv