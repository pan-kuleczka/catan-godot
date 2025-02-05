from .CardType import CardType
from .Inventory import Inventory

class Bank:
    def __init__(self, preset, playerCount):
        if preset == "base":
            #tu sa koszta jako Inv zeby bank sobie mogl porownywac czy stac kogos czy nie 
            self.settlement_cost = Inventory([1,1,1,1,0,0,0,0])
            self.city       = Inventory([0,0,0,2,3,0,0,0])
            self.road       = Inventory([1,1,0,0,0,0,0,0])
            self.knight     = Inventory([0,0,1,0,1,0,0,0])
            self.politics   = [Inventory(coin = i) for i in range(1,6)]
            #tu jest eq banku
            self.bank       = Inventory([6*playerCount]*8)
    