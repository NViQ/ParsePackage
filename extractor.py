def get_additional_parameters(value):
    # Получаем второй байт исходного значения
    second_byte = (value >> 16) & 0xFF

    # Инвертируем 7-й бит исходного значения
    bit_7 = (value >> 6) & 1  # Получение значения 7-го бита
    inverted_bit_7 = bit_7 ^ 1

    # Получаем биты 17-20 исходного значения и зеркально отображаем их
    bits_17_20 = (value >> 16) & 0xF
    reversed_bits = int(bin(bits_17_20)[2:][::-1], 2)

    # Возвращаем значения дополнительных параметров
    return second_byte, inverted_bit_7, reversed_bits

# Исходное значение
value = 0x5FABFF01

# Получаем значения дополнительных параметров
param1, param2, param3 = get_additional_parameters(value)

# Выводим значения на экран
print(f"Первый дополнительный параметр: {param1}")
print(f"Второй дополнительный параметр: {param2}")
print(f"Третий дополнительный параметр: {param3}")
