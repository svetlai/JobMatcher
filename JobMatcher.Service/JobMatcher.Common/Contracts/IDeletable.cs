using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JobMatcher.Common.Contracts
{
    public interface IDeletable
    {
        bool IsDeleted { get; set; }
    }
}
