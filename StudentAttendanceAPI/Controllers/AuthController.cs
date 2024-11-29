using BusinessObjects.DTO;
using BusinessObjects.DTO.StudentDTO;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Repositories.Interface;

namespace StudentAttendanceAPI.Controllers
{
    [Route("api/[controller]")]
	[ApiController]
	public class AuthController : ControllerBase
	{
		private readonly IAuthService _authService;

		public AuthController(IAuthService authService)
		{
			_authService = authService;
		}

		[HttpPost("LoginByTeacher")]
		public async Task<IActionResult> LoginByTeacher([FromBody] TeacherLoginDTO loginDTO)
		{
			try
			{
				var token = await _authService.LoginAsync(loginDTO);
				return Ok(new { Token = token });
			}
			catch (UnauthorizedAccessException ex)
			{
				return Unauthorized(ex.Message);
			}
			catch (Exception ex)
			{
				return StatusCode(500, ex.Message);
			}
		}
		[HttpPost("LoginByStudent")]	
		public async Task<IActionResult> LoginByStudent([FromBody] StudentLoginDTO loginStudentDTO)
		{
			try
			{
				var token = await _authService.LoginByStudentAsync(loginStudentDTO);
				return Ok(new { Token = token });
			}
			catch (UnauthorizedAccessException ex)
			{
				return Unauthorized(ex.Message);
			}
			catch (Exception ex)
			{
				return StatusCode(500, ex.Message);
			}
		}
	}
}
