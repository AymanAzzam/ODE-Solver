#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np


# In[6]:


def interpolation (M, T, U, Tcurrent):
    for i in range(len(T)):
        if (Tcurrent < T[i]):
            index_bigger = i
            Tbigger = T[i]
            Tsmaller = T[i-1]
            break;
    Ubigger = U[index_bigger]
    Usmaller = U[index_bigger - 1]
    U_interpolated = Usmaller + ((Tcurrent - Tsmaller)/(Tbigger -Tsmaller))* (Ubigger-Usmaller)
    print("done interpolation")
    return U_interpolated


# In[8]:


M =3
Tcurrent = 1.5
T = np.array([1,2,3,4])
U = np.array([[1,2,3,4], [2,4,6,8],[1,2,3,4],[1,2,3,4]])
print (interpolation (M, T, U, Tcurrent))


# In[ ]:




