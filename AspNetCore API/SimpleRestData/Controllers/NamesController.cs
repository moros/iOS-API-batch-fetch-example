using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;

namespace SimpleRestData.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NamesController : ControllerBase
    {
        private readonly NameContext _context;

        public NamesController(NameContext context)
        {
            _context = context;
        }

        [HttpGet]
        [Route("fetch")]
        public ActionResult<IEnumerable<Name>> FetchNames(int offset = 0)
        {
            var names = _context.Names as IQueryable<Name>;
            if (offset != 0)
                names = names.Skip(offset);

            return names.Take(100).ToList();
        }
    }
}
