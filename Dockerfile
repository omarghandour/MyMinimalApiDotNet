# Learn about building .NET container images:
# https://github.com/dotnet/dotnet-docker/blob/main/samples/README.md
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /source

# Copy project file. and restore as distinct layers 
COPY *.csproj .
RUN dotnet restore

# Copy source code and publish app
COPY . .
RUN dotnet publish -o /app

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=build /app .
EXPOSE 3000
ENV ASPNETCORE_HTTP_PORTS=3000
ENTRYPOINT ["dotnet", "MyMinimalApiDotNet.dll"]
