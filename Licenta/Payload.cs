﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Licenta
{

    public class Payload<T>
    {
        public T Value { get; set; }

        public override string ToString()
        {
            return "[StreamInsight]\tValue: " + Value.ToString();
        }
    }
}
