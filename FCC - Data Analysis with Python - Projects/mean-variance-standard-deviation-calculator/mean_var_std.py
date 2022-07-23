import numpy as np

def calculate(list_tw):

    if len(list_tw)==9:

        values=np.array(list_tw)
        values_tw=values.reshape(3,3)
        mean = [ (np.mean(values_tw, axis=0)).tolist(), (np.mean(values_tw, axis=1)).tolist(), np.mean(values_tw) ] 
        variance= [ np.var(values_tw, axis=0).tolist(), np.var(values_tw, axis=1).tolist(), np.var(values_tw)]
        standard_deviation = [np.std(values_tw, axis=0).tolist(), np.std(values_tw, axis=1).tolist(), np.std(values_tw)]
        max_values = [np.max(values_tw, axis=0).tolist(), np.max(values_tw, axis=1).tolist(), np.max(values_tw)]
        min_values = [np.min(values_tw, axis=0).tolist(), np.min(values_tw, axis=1).tolist(), np.min(values_tw)]
        sum_values = [np.sum(values_tw, axis=0).tolist(), np.sum(values_tw, axis=1).tolist(), np.sum(values_tw)]

        dic={
          'mean': mean,
          'variance': variance,
          'standard deviation': standard_deviation,
          'max': max_values,
          'min': min_values,
          'sum': sum_values,
        }

        return dic
    else:
        raise ValueError("List must contain nine numbers.")



   # return calculations