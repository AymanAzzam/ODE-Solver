#import sys
import numpy as np

import random
def decimal_converter(num):  
    while num > 1: 
        num /= 10
    return num 

def float_bin(number, places = 8): 
  
    whole, dec = str(number).split(".") 
  
    whole = int(whole) 
    dec = int (dec) 
  
    res = bin(whole).lstrip("0b") + "."
  
    for x in range(places): 
        
        if dec !=0 and dec !=1:
            whole, dec = str((decimal_converter(dec)) * 2).split(".") 
        
            dec = int(dec) 
            res += whole
        
        else:
            res += "0" 
  
    return res 


def divide(dd,divisor): # the last position that divisor* val <  dd
    s = 0
    for i in range(9):
        tmp = s + divisor
        if tmp <= dd:
            s = tmp
        else:
            return str(i), str(dd-s)
    return str(9), str(dd-s)



f = open("data.txt", "w")
for i in range(10):
#    A = random.uniform(1.0,128.0)
#    B = random.uniform(1.0,A)
    
    A = random.uniform(1.0,128.0)
    B = random.uniform(1.0,A)
    
    bin_A = float_bin(A)       
    bin_B = float_bin(B)

    bin_A = bin_A.replace(".","")
    bin_B = bin_B.replace(".","")



    ans, did, dr = [], str(int(bin_A,2)), str(int(bin_B,2))
    n = len(dr)
    pre = did[:n-1]
    for i in range(n-1, len(did)):
        dd = pre+did[i]
        dd = int(dd)
        v, pre = divide(dd,int(bin_B,2))
        ans.append(v)

    res=" "
    print(ans)
    for i in range(0, len(ans)):
    
        res = res + ans[i]
        i=i+1
    
#    print(res)
#    print(pre)
    
    while len(bin_A)!=16:
        bin_A = "0"+bin_A
    
    while len(bin_B)!=16:
        bin_B = "0"+bin_B
        
    res = bin(int(res)).lstrip("0b")
    pre = bin(int(pre)).lstrip("0b")
    print(res)
    while len(res)!=8:
        res = "0"+res
    while len(res)!=16:
        res = res+"0"
    while len(pre)!=16:
        pre = "0"+pre
    
    arr = [str(bin_A) ," _ ",str(bin_B) ," _ ",str(res)," _ ", str(pre)]
    f.writelines(arr)
    f.write("\r")

f.close()

#div = int(bin_A,2)
#dis = int(bin_B,2)
#result = "0"
#print(div,dis)
#for x in range(1,len(bin_A)):
#
#    dec1 = int(bin_A[0:x],2)
#    dec2 = int(bin_B,2)
#    
#    if dec1 >= dec2:
#        bin_A = bin_A.join([bin_A[0:x], str(bin(dec1 - dec2))])
#        dec2 = dec2 >>1
#        result = result + "1"
#        print(bin_A)
#    else:
#        result = result + "0"
#        
#print(result,int(bin_A,2))    

#while len(one[0])!=8:
#    one[0] = "0"+one[0]
#    print(one)
#    
#while len(two[0])!=8:
#    two[0] = "0"+two[0] 
#    
#bin_B = one[0]+one[1] 
#bin_A = two[0]+two[1] 
#
#print(bin_B)
#print(bin_A)
#print(int(bin_A.replace(".",""),2),int(bin_B.replace(".",""),2),"decimaaaaaal")
#bin_B = "0"+bin_B.replace(".","")+"000000000000000"
#bin_A =  "0000000000000000" + bin_A.replace(".","")
#qui = np.zeros((31,1))
#
#div = np.zeros((32,1))
#dis = np.zeros((32,1))
#for i in range(0,32):
#    div[i] = bin_A[i]
#    dis[i] = bin_B[i]
#    
#print(len(div))
#print(len(dis))   

#qui_dec = int(qui,2)

#print(bin_B,int(bin_B),"bla")
#print(bin_A,int(bin_A))
#
#
#for x in range(0,16):
#    A_dec = int(bin_A,2)
#    B_dec = int(bin_B,2)
#    if A_dec >= B_dec:
#        
##        qui_dec = qui_dec << 1
##        qui = bin(qui_dec)
##        A_dec = A_dec - B_dec
##        qui[0] = 1
##        B_dec= B_dec >> 1
#        print(qui,x)
#        
#    else:
#         qui_dec = qui_dec << 1
#         qui = bin(qui_dec)
#         B_dec= B_dec >> 1
#         print(qui,x,qui_dec)
#         
#         
#remain =  bin(A_dec)[0:16]
#qui =     qui[0:7] +"00000000"
#
#print(remain, "  ",int(remain,2))
#print(qui, "  ",int(qui,2))

#A_dec = int(bin_A.replace(".",""),2)
#B_dec = int(bin_B.replace(".",""),2)


#s_length =0 
#m_length=0
#if len(bin(s_result)) > 18:
#    s_length = len(bin(s_result)) - 16
#if len(bin(m_result)) >18:
#    m_length = len(bin(m_result)) - 16
#print("the addition result =" ,s_result,bin(s_result)[s_length:])
#print("the multiplaciton result =" ,m_result,bin(m_result)[m_length:])

