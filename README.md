# Python_SQL_DataInsights

```python
import chardet

with open('TR3_DSBD_MARGIN_TRANS.csv', 'rb') as f:
    result = chardet.detect(f.read())

print(result['encoding'])
ascii
with open('TRANSIT2_REMONT_ORDERS.csv', 'rb') as f:
    result = chardet.detect(f.read())

print(result['encoding'])
KOI8-R

with open('TRANSIT2_REMONT_PARTS.csv', 'rb') as f:
    result = chardet.detect(f.read())

print(result['encoding'])
windows-1251

with open('TRANSIT2_REMONT_WORKS.csv', 'rb') as f:
    result = chardet.detect(f.read())

print(result['encoding'])
windows-1251

import pandas as pd
from IPython.display import FileLink

# Загрузите данные из CSV файла с правильной кодировкой (например, cp1251)
data = pd.read_csv('TR3_DSBD_MARGIN_TRANS.csv', encoding='ascii')

# Преобразуйте данные в формат JSON и сохраните их в файл
data.to_json('TR3_DSBD_MARGIN_TRANS.json', orient='records', lines=True, force_ascii=False)
 
# Создайте объект FileLink для вашего JSON файла
json_link = FileLink('TR3_DSBD_MARGIN_TRANS.json')

# Выведите ссылку для скачивания файла
json_link
TR3_DSBD_MARGIN_TRANS.json

import pandas as pd
# Берем 'TR3_DSBD_MARGIN_TRANS.csv' 
df = pd.read_csv('TR3_DSBD_MARGIN_TRANS.csv', delimiter=';')

df.head()
# Сортировка DataFrame по столбцу DT_month
df = df.sort_values(by='DT_MONTH')
# Вычисляем прирост активных карт месяц к месяцу и добавим результат в новый столбец:
df['Monthly_Increase'] = df['ACTIVE_CARDS'].diff()
# Преобразование столбца DT_MONTH в тип datetime
df['DT_MONTH'] = pd.to_datetime(df['DT_MONTH'], format='%Y-%m-%d')

# Группировка данных по месяцам и вычисление суммы
grouped_df = df.groupby(df['DT_MONTH'].dt.strftime('%Y-%m')).agg({
    'ACTIVE_CARDS': 'sum'
}).reset_index()

# Переименование индекса
grouped_df = grouped_df.rename(columns={'DT_MONTH': 'Дата'})

print(grouped_df)
# Установка размеров графика
plt.figure(figsize=(12, 6))

# Построение столбчатой диаграммы для прироста
plt.bar(grouped_df['DT_MONTH'], grouped_df['Monthly_Increase'], color='g', alpha=0.7)

# Настройка осей и меток
plt.xlabel('Дата')
plt.ylabel('Прирост')
plt.title('График прироста активных карт по месяцам')
plt.xticks(rotation=45)
plt.grid(True)

# Показать график
plt.tight_layout()
plt.show()
import os
# Определите путь для сохранения графика в домашней директории
home_directory = os.path.expanduser("~")
save_path = os.path.join(home_directory, 'График прироста активных карт по месяцам.png')

# Сохраните график в формате .png в домашней директории
plt.savefig(save_path, format='png')

![](https://github.com/L13nar/Python_SQL_DataInsights/blob/main/График прироста активных карт по месяцам.png)
```python
