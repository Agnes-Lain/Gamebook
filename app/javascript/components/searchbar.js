const authorization = "fa839f5f17334fe692bd1f9a606bfa88";

const initSearchBar = () => {
  const searchByGame = document.getByElementId('.search-games');
  const consoleModel = document.getByElementId("console-model")
  const button = document.getByElementId("search-submit")
  const form = document.getByElementId("search-games")

  const getGameName = () => searchByGame.value
  const getConsole = () => consoleModel.value

  const callRawgApi = (condition, callback) => {
    const url = `https://api.rawg.io/api/games?key=${authorization}&search=${condition}`
    fetch(url, {headers: {Authorization: authorization}})
      .then(response => response.json())
      .then((data) => {
        callback(data);
        console.log(data)
      });
  }

  form.addEventListener('submit', (event)=>{
    event.preventDefault()
    const gameName = getGameName()
    const consoleName = getConsole()
    callRawgApi(option option action)
  });


export { initUpdateNavbarOnScroll };
