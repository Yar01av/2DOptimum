namespace HelloWorld {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;


    operation Parameterize(qs : Qubit[], parameters : Double[]) : Unit {
            for (i in 0..parameters.Length-1) {
                Rx(parameters[i], qs[i]);
            }
    }

    operation GetLoss(parameters: Double[], n_iterations: Int) : Double {
        mutable loss = 0.0;

        using (qs = Qubit[parameters.Length]) {
            for (i in 0..n_iterations-1) {
                mutable measurements = new Int[parameters.Length];

                // Set up the qubits
                Parameterize(qs, parameters);

                // Measure the qubits
                for (k in qs.Length) {
                    set measurements w/= k <- ResultArrayAsInt([MReset(qs[k])]);
                }

                // Calculate loss
                for (k in 0..qs.Length-1) {
                    // TODO: add a more sophisticated loss function
                    set loss += measurements[k];
                }
            }

            return loss/IntAsDouble(n_iterations);
        }
    }
}