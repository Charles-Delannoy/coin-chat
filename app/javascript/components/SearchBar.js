import React, { Fragment } from "react"
import PropTypes from "prop-types"
const SearchBar = ({ term, setTerm }) => {
  return (
    <Fragment>
      <form>
        <div>
          <input
            className='searchbar'
            placeholder='Search by name'
            type="text"
            value={term}
            onChange={e => setTerm(e.target.value)}
          />
        </div>
      </form>
    </Fragment>
  );
}

export default SearchBar;
