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
```
![](https://github.com/L13nar/Python_SQL_DataInsights/blob/main/График%20прироста%20активных%20карт%20по%20месяцам.png)
```python

import pandas as pd
import matplotlib.pyplot as plt

# Берем 'TR3_DSBD_MARGIN_TRANS.csv' 
df = pd.read_csv('TRANSIT2_REMONT_ORDERS.csv', delimiter=';', encoding='KOI8-R')

df.head()

# Убедимся, что столбец TOTAL_AMOUNT имеет строковый формат
df['TOTAL_AMOUNT'] = df['TOTAL_AMOUNT'].astype(str)

# Заменяем запятые на точки и преобразуем в float
df['TOTAL_AMOUNT'] = df['TOTAL_AMOUNT'].str.replace(',', '.').astype(float)

# Фильтрация данных
filtered_df = df[
    (df['CAR_NUMBER'].str.contains('[А-Яа-я0-9]')) &
    (df['TOTAL_AMOUNT'] > 0) &
    ~((df['CAR_NUMBER'].str.contains('0000')) | (df['CAR_NUMBER'].str.contains('-')))
]

# Группировка и вычисление агрегатных значений
grouped_df = filtered_df.groupby('ID_CONT').agg(
    {
        'CAR_NUMBER': 'count',
        'TOTAL_AMOUNT': 'sum'
    }
).reset_index()

# Вывод результатов
print(grouped_df)
# Преобразование данных в числовой формат
grouped_df['CAR_NUMBER'] = pd.to_numeric(grouped_df['CAR_NUMBER'], errors='coerce')
grouped_df['TOTAL_AMOUNT'] = pd.to_numeric(grouped_df['TOTAL_AMOUNT'], errors='coerce')

# Вычисление колонки TOTAL_AMOUNT_PER_CAR
grouped_df['TOTAL_AMOUNT_PER_CAR'] = grouped_df['TOTAL_AMOUNT'] / grouped_df['CAR_NUMBER']

# Сортировка данных по убыванию значения TOTAL_AMOUNT_PER_CAR и выбор топ-5
top_5_data = grouped_df.sort_values(by='TOTAL_AMOUNT_PER_CAR', ascending=False).head(5)

# Построение столбчатой диаграммы
plt.figure(figsize=(12, 6))
plt.bar(top_5_data['ID_CONT'], top_5_data['TOTAL_AMOUNT_PER_CAR'])
plt.xlabel('ID_CONT')
plt.ylabel('TOTAL_AMOUNT_PER_CAR')
plt.title('Топ-5 ID_CONT по TOTAL_AMOUNT_PER_CAR')
plt.xticks(rotation=45)  # Поворот меток по оси X для лучшей читаемости
plt.tight_layout()
plt.show()
```
![](https://github.com/L13nar/Python_SQL_DataInsights/blob/main/Топ-5 ID_CONT Amount per Car.png)
```python
