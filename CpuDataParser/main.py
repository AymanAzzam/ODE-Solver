import json
import sys
import constants
import numpy as np


def convert_to_binary(value, number_of_bits, number_type):
    if number_type == "integer":
        extended_value = str(bin(value)).lstrip("0b")
        extended_value = ("0" * (number_of_bits - len(extended_value))) + extended_value
        return extended_value
    if number_type == "fixed":
        integer_part = int(value)
        fraction_part = value - integer_part

        extended_value = str(bin(integer_part)).lstrip("0b")
        extended_value = ("0" * (int(number_of_bits / 2) - len(extended_value))) + extended_value

        for x in range(int(number_of_bits / 2)):
            integer_part, fraction_part = str(float(2 * fraction_part)).split(".")

            fraction_part = float("." + fraction_part)

            extended_value += integer_part
        return extended_value


def run_length_encoding(uncompressed_data):
    compressed_data = []
    for row in uncompressed_data:
        temp_row = ""
        count = 0
        element = row[0]
        for i in row:
            if i == element and count < constants.RUN_SIZE:
                count += 1
            else:
                if count > 0:
                    temp_row = temp_row + element + convert_to_binary(count, constants.RUN_BITS_SIZE, "integer")
                count = 1
                element = i
        temp_row = temp_row + element + convert_to_binary(count, constants.RUN_BITS_SIZE, "integer")
        compressed_data.append(temp_row)

    return compressed_data


def main():
    ################################# LOAD JSON FILE ###############################

    try:
        input_file = open('input.json')
    except IOError:
        print("ERROR: Please make sure that a readable input.json file exists in the current directory")
        input("Press Enter to exit...")
        sys.exit()

    input_data = json.load(input_file)

    n = input_data["N"]
    m = input_data["M"]
    solver_mode = input_data["Mode"]
    time_step = input_data["H"]
    error_tolerance = input_data["Err"]
    precision = input_data["Fixedpoint"]
    time_steps_count = input_data["Count"]
    a = np.asarray(input_data["A"])
    b = np.asarray(input_data["B"])
    x0 = np.asarray(input_data["X0"])
    t = np.asarray(input_data["T"])
    u0 = np.asarray(input_data["U0"])
    us = np.asarray(input_data["Us"])

    input_file.close()

    ################################ VALIDATE INPUT ################################

    print("- Checking input validity...")

    if n not in constants.N_RANGE:
        print("ERROR: N is out of range")
        input("Press Enter to exit...")
        sys.exit()

    if m not in constants.M_RANGE:
        print("ERROR: M is out of range")
        input("Press Enter to exit...")
        sys.exit()

    if solver_mode not in constants.SOLVER_MODES:
        print("ERROR: No such mode (" + str(solver_mode) + ")exists")
        input("Press Enter to exit...")
        sys.exit()

    if time_step < 0:
        print("ERROR: Time step 'h' can't have a negative value")
        input("Press Enter to exit...")
        sys.exit()

    if error_tolerance < 0:
        print("ERROR: Error tolerance can't have a negative value")
        input("Press Enter to exit...")
        sys.exit()

    if precision not in constants.PRECISION:
        print("ERROR: No such precision (" + str(precision) + ")exists")
        input("Press Enter to exit...")
        sys.exit()

    if time_steps_count < 0:
        print("ERROR: Count of time steps needed can't have a negative value")
        input("Press Enter to exit...")
        sys.exit()

    if a.shape != (n, n):
        print("ERROR: Incorrect matrix A dimensions")
        input("Press Enter to exit...")
        sys.exit()

    if b.shape != (n, m):
        print("ERROR: Incorrect matrix B dimensions")
        input("Press Enter to exit...")
        sys.exit()

    if x0.shape != (n,):
        print("ERROR: Incorrect vector X0 dimension")
        input("Press Enter to exit...")
        sys.exit()

    if t.shape != (time_steps_count,):
        print("ERROR: Count of time steps needed doesn't match length of array T")
        input("Press Enter to exit...")
        sys.exit()

    if u0.shape != (m,):
        print("ERROR: Incorrect vector U0 dimension")
        input("Press Enter to exit...")
        sys.exit()

    if us.shape != (time_steps_count, m):
        print("ERROR: Incorrect vector Us dimension")
        input("Press Enter to exit...")
        sys.exit()

    print("- Input is valid")

    ##################### CONVERT DATA TO BINARY IN ROW FORMAT #####################

    print("- Converting input data to binary...")

    output_data = []

    temp_row = convert_to_binary(n, constants.DATA_SIZE, "integer")
    temp_row = temp_row + convert_to_binary(m, constants.DATA_SIZE, "integer")
    temp_row = temp_row + convert_to_binary(solver_mode, constants.DATA_SIZE, "integer")
    temp_row = temp_row + convert_to_binary(time_step, constants.DATA_SIZE, "fixed")
    temp_row = temp_row + convert_to_binary(error_tolerance, constants.DATA_SIZE, "fixed")
    temp_row = temp_row + convert_to_binary(precision, constants.DATA_SIZE, "integer")
    temp_row = temp_row + convert_to_binary(time_steps_count, constants.DATA_SIZE, "integer")

    output_data.append(temp_row)

    for row in a:
        temp_row = ""
        for i in row:
            temp_row = temp_row + convert_to_binary(i, constants.DATA_SIZE, "fixed")
        output_data.append(temp_row)

    for row in b:
        temp_row = ""
        for i in row:
            temp_row = temp_row + convert_to_binary(i, constants.DATA_SIZE, "fixed")
        output_data.append(temp_row)

    temp_row = ""
    for i in x0:
        temp_row = temp_row + convert_to_binary(i, constants.DATA_SIZE, "fixed")
    output_data.append(temp_row)

    temp_row = ""
    for i in t:
        temp_row = temp_row + convert_to_binary(i, constants.DATA_SIZE, "fixed")
    output_data.append(temp_row)

    temp_row = ""
    for i in u0:
        temp_row = temp_row + convert_to_binary(i, constants.DATA_SIZE, "fixed")
    output_data.append(temp_row)

    for row in us:
        temp_row = ""
        for i in row:
            temp_row = temp_row + convert_to_binary(i, constants.DATA_SIZE, "fixed")
        output_data.append(temp_row)

    print("- Conversion complete")

    ############################## COMPRESS DATA ###############################

    print("- Compressing converted data...")
    compressed_output_data = run_length_encoding(output_data)
    print("- Compression complete")

    ############################### OUTPUT DATA ################################

    output_file = open("output.txt", "w+")
    for row in compressed_output_data:
        output_file.write(row + "\n")
    output_file.close()

    print("\n")
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    print("+++++++++++ CPU data parsing has completed successfully. Check file 'output.txt' +++++++++++")
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
    print("\n")

    input("Press Enter to exit...")


if __name__ == "__main__":
    main()
