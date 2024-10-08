using Microsoft.AspNetCore.SignalR;

namespace StudentAttendanceClient
{
    public class SignalHub : Hub
    {
        // Gửi thông báo đến tất cả client
        public async Task SendUpdate()
        {
            await Clients.All.SendAsync("ReceiveUpdate");
        }
    }
}
