//
//  calculatorModel.swift
//  first
//
//  Created by Mahmoud El-Tarrasse on 7/29/17.
//  Copyright © 2017 Mahmoud El-Tarrasse. All rights reserved.
//

import Foundation

class calculatorBrain{
    
    private var accumulator = 0.0
    
    private var pending: PendingBinaryOperationInfo?
    
    var operations: Dictionary<String, Operation> = [
        "Pi": Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "sin" : Operation.unaryOperation(sin),
        "x" : Operation.BinaryOperation({$0 * $1}),
        "/" : Operation.BinaryOperation({$0 / $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "-" : Operation.BinaryOperation({$0 - $1}),
        "=" : Operation.Equals
    ]
    
    func setOperand(openrand: Double){
        accumulator = openrand
    }
    
    func performOperation(symbol: String)  {
        if let operation = operations[symbol]{
            switch operation {
            
            case .constant(let value):
                accumulator = value
                break
            case .BinaryOperation(let function):
                exexutePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function,firstOperand: accumulator)
                break
            case .unaryOperation (let function): accumulator = function(accumulator)
                break
            case .Equals:
                exexutePendingBinaryOperation()
            }
        }
    }
    
    func exexutePendingBinaryOperation(){
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }

    }
    
    var result : Double{
        get{
            return accumulator
        }
    }
    
}

struct PendingBinaryOperationInfo {
    var binaryFunction: ((Double, Double) -> Double)
    var firstOperand: Double
}

enum Operation {
    case constant(Double)
    case unaryOperation((Double) -> Double)
    case BinaryOperation((Double,Double)->Double)
    case Equals
}
