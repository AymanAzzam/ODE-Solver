import sys


f = open("testfile.txt", "r")
out = open("test_out.txt", "w")

x = f.readline()
while x:
    numbers = x.split()
    A = numbers[0]
    B = numbers[1]
 
    result = bin(int(A,2) + int(B,2))
    
   # out.write(A+"\n")
    #out.write(B+"\n")
   
    result = int(result,2)
    result = str(result)
    out.write(result+"\n")

    
    x = f.readline()
out.close()
f.close()


