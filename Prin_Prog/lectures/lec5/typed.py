from typing import List,Dict,Tuple

x: int = 42
name: str = "Bob"
zips: List[int] = [ 12345, 90210 ]
bobUser: Tuple[str, int, str] = ("bob", 500, "/home/bob")

def f(s: str) -> int:
    return len(s)

states: Dict[str, str] = {
    'New Jersey': 'NJ' }

if x < 10:
    x = x + " dollars"
    f(x)
    zips.append(3.1415)
