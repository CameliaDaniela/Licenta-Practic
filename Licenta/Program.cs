using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Licenta
{
    class Program
    {
        static void Main(string[] args)
        {

            //StreamInsight streamInsight = new StreamInsight(4,10);
            StreamInsight streamInsight = new StreamInsight(10, 10, 10, 6);
            for (int i = 1; i <= 30; i++)
                streamInsight.App(i);
            //no values/ minute, no events in the flow, no road segments, window size


        }

    }
}
