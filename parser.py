def parse_package(package):
    #Проверяем, что строка начинается символом разделителя
    if not package.startswith("#"):
        print("Ошибка: некорректный формат пакета1")
        return

    # Разделяем строку на составляющие
    parts = package[1:].strip().split("#")
    parts_atr = parts[1].split(";")

    # Проверяем тип пакета
    package_type = parts[0]
    if package_type == "SD":
        parse_sd_package(parts_atr)
    elif package_type == "M":
        parse_m_package(parts_atr)
    else:
        print("Ошибка: неизвестный тип пакета")


def parse_sd_package(parts):
    if len(parts) != 10:
        print("Ошибка: некорректное количество полей в пакете SD")
        return

    data_db = {
        "date": parts[0],
        "time": parts[1],
        "lat1": float(parts[2]),
        "lat2": parts[3],
        "lon1": float(parts[4]),
        "lon2": parts[5],
        "speed": int(parts[6]),
        "course": int(parts[7]),
        "height": int(parts[8]),
        "sats": int(parts[9])
    }

    data_out = {
        "Тип пакета": "SD",
        "Дата": data_db["date"],
        "Время": data_db["time"],
        "Широта": (data_db["lat1"], data_db["lat2"]),
        "Долгота": (data_db["lon1"], data_db["lon2"]),
        "Скорость": str(data_db["speed"]) + " км/ч",
        "Курс": str(data_db["course"]) + " градусов",
        "Высота": str(data_db["height"]) + " м",
        "Количество спутников": data_db["sats"]
    }

    for key, value in data_out.items():
        print(key + ":", value)

    return data_db


def parse_m_package(parts):
    if len(parts) != 1:
        print("Ошибка: некорректное количество полей в пакете M")
        return

    data = {
        "Тип пакета": "M",
        "Сообщение": parts[0],
    }

    for key, value in data.items():
        print(key + ":", value)

    return data



#Пример использования
package1 = "#SD#04012011;135515;5544.6025;N;03739.6834;E;35;215;110;7\r\n"
package2 = "#M#груз доставлен\r\n"

parse_package(package1)
print("-----------")
parse_package(package2)

