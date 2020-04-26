#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np


# In[9]:


def euler (T,U,H,A,B,X0):
    Xcurrent = X0
    i=0
    while i < len(T):
        AXn = A.dot(Xcurrent)
        BUn = B.dot(U[i])
        Xnext =  Xcurrent + H*(AXn + BUn)
        print ("X["+ str(i+1) + "] =")
        print(Xnext)
        i = i+1
    return    


# In[10]:


T = np.array([1,2])
H = 1
X0 = np.array([1, 2]) 
A = np.array([[1,1],[2,2]])
B = np.array([[1,2,3],[4,5,6]])
U = np.array([[1,2,3], [4,5,6]])
euler (T,U,H,A,B,X0)


# In[ ]:




