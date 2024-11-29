using BusinessObjects.Models;

namespace StudentAttendanceClient.APIFunction
{
    public class CourseAPI
    {
        private static readonly HttpClient client = new HttpClient();

        public static async Task<List<Course>> GetListCourseAsync()
        {
            string url = "http://localhost:5019/api/Course/GetAllCourse";
            try
            {
                HttpResponseMessage response = await client.GetAsync(url);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<List<Course>>();
                }
                else
                {
                    // Log or handle response error
                    Console.WriteLine("API Error: " + response.ReasonPhrase);
                    return new List<Course>();
                }
            }
            catch (HttpRequestException ex)
            {
                // Log HTTP request error
                Console.WriteLine("HTTP Request Error: " + ex.Message);
                return new List<Course>();
            }
        }
    }
}
