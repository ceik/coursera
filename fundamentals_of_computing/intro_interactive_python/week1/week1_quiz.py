### Quiz Week 1

n = 123
print ((n - n % 10) % 100) / 10
print (n % 100 - n % 10) / 10
print (n % 10) / 10

#  f(x) = -5 x^5 + 69 x^2 - 47

def f(x):
    return -5 * x**5 + 69 * x**2 - 47

print f(0)
print f(1)
print f(2)
print f(3)




import math

def future_value(present_value, annual_rate, periods_per_year, years):
    rate_per_period = annual_rate / periods_per_year
    periods = periods_per_year * years
    
    fv = present_value * (1 + rate_per_period) ** periods
    return fv

print future_value(500, .04, 10, 10)
    
print "$1000 at 2% compounded daily for 3 years yields $", future_value(1000, .02, 365, 3)



n = 7
s = 3

def area_poly(n, s):
    area = 0.25 * n * s**2 / math.tan(math.pi / n)
    return area

print area_poly(n, s)


def max_of_2(a, b):
    if a > b:
        return a
    else:
        return b

def max_of_3(a, b, c):
    return max_of_2(a, max_of_2(b, c))




def project_to_distance(point_x, point_y, distance):
    dist_to_origin = math.sqrt(point_x ** 2 + point_y ** 2)    
    scale = distance / dist_to_origin
    print point_x * scale, point_y * scale
    
project_to_distance(2, 7, 4)