import qsharp
from scipy.optimize import minimize
from HelloWorld import GetLoss


def objective(x):
    GetLoss.simulate(parameters=x, n_iterations=100)

params = [.0, .0, .0]
result = minimize(objective, params, method="Powell")

print("Minimum loss:", result.fun)
print("Minimum parameter:", result.x)