using AutoMapper;
using BusinessObjects.DTO;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Repositories.Interface;

namespace StudentAttendanceAPI.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class ClassController : ControllerBase
	{
        private readonly IMapper _mapper;

        public IClassRepository _classRepository;
		public ClassController(IClassRepository classRepository, IMapper mapper)
		{
			_classRepository = classRepository;
            _mapper = mapper;

        }

        [HttpGet("{id}")]
		public async Task<IActionResult> GetClassById(int id)
		{
			var classData = await _classRepository.GetClassByIdAsync(id);
			if (classData == null) return NotFound();
            var classDTO = _mapper.Map<ClassDTO>(classData);

            return Ok(classDTO);
		}

      
    }
}
